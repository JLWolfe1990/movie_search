require 'rails_helper'

RSpec.describe Api::V1::SearchesController, type: :controller do
  describe 'get index' do
    let(:params) do
      {
        query: query
      }
    end

    subject { get :index, params: params}

    context 'when the query term is nil' do
      let(:query) { nil }

      it_should_behave_like 'a bad request'
    end

    context 'when the query term is empty' do
      let(:query) { "" }

      it_should_behave_like 'a bad request'
    end

    context 'when the query term is valid' do
      context 'when there is not a cache for the query' do
        let(:movie_title) { 'Harry Potter and the Prisoner of Askaban' }

        let(:query) { movie_title }

        let(:expected_json) do
          [
            {
              title: movie_title.titlecase
            }
          ].as_json
        end

        let(:search_results) do
          [{
            "Title" => movie_title
          }].as_json
        end

        it 'should return the movies in the correct JSON format' do
          expect(Search.count).to eq(0)
          allow_any_instance_of(Services::Omdb).to receive(:search_results).and_return(search_results)

          subject

          expect(response_json).to eq(expected_json)
        end

        context 'when the API does not return a successful response' do
          let(:error_message) { 'Too many results' }
          before do
            allow_any_instance_of(Services::Omdb).to receive(:search_results).and_raise(Services::Omdb::Error.new(error_message))
          end

          it 'should log the message' do
            expect(Rails.logger).to receive(:error).with("[Api::V1::SearchesController] OMDb threw error 'Too many results'")

            subject
          end

          it 'should return an empty array' do
            subject

            expect(response_json).to eq([])
          end

          it 'should return :not_acceptable' do
            subject

            expect(response.status).to eq(406)
          end
        end

        context 'when there is an existing search that is old' do
          let!(:search) do
            create(:search, query: query)
          end

          before { search.update created_at: 3.days.ago }

          it 'should create a new query' do
            expect_any_instance_of(Services::Omdb).to receive(:search_results).and_return(search_results)

            expect { subject }.to change(Search, :count).by(1)
          end
        end
      end

      context 'when the query term matches a movie' do
        let(:query) { 'Hot Pursuit' }

        let(:search) do
          create(:search, query: query)
        end

        let!(:movie1) do
          create(:movie).tap do |movie|
            search.movies << movie
          end
        end

        let!(:movie2) do
          create(:movie).tap do |movie|
            search.movies << movie
          end
        end

        it 'should return the existing search results' do
          expect { subject }.to_not change(Search, :count)
        end

        it 'should return an array of movies' do
          subject
          expect(response).to be_successful
          expect(response_json).to be_an(Array)
          expect(response_json.length).to eq(2)
        end

        it 'should not be case sensitive' do
          search.update query: search.query.upcase

          subject
          expect(response).to be_successful
          expect(response_json).to be_an(Array)
          expect(response_json.length).to eq(2)
        end

        it 'should return the movies in the correct JSON format' do
          expected_json = [
            {
              title: movie1.title.titlecase,
            },
            {
              title: movie2.title.titlecase,
            }
          ].as_json

          subject

          expect(response_json).to eq(expected_json)
        end
      end

      context 'when the query term does not match a movie' do
        let(:query) { 'Not a real movie title' }

        before do
          allow_any_instance_of(Services::Omdb).to receive(:search_results).and_return([])
        end

        it 'should return an empty array' do
          subject
          expect(response).to be_successful
          expect(response_json).to be_an(Array)
        end

        it 'should create a new search' do
          expect { subject }.to change(Search, :count).by(1)
        end
      end
    end
  end
end