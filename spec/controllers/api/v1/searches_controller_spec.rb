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
      context 'when the query term matches a movie' do
        let(:query) { 'Hot Pursuit' }

        let(:search) do
          create(:search, query: query)
        end

        let!(:movie1) do
          create(:movie, search: search)
        end

        let!(:movie2) do
          create(:movie, search: search)
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
              description: movie1.description
            },
            {
              title: movie2.title.titlecase,
              description: movie2.description
            }
          ].as_json

          subject

          expect(response_json).to eq(expected_json)
        end
      end

      context 'when the query term does not match a movie' do
        let(:query) { 'Not a real movie title' }

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