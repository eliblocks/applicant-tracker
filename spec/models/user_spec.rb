require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:jack) { User.create!(name: "Jack",
                                email: "jack@example.com",
                                password: "password") }

  let!(:fountain) { User.create!(name: "Fountain",
                                email: "carrers@fountain.com",
                                password: "password",
                                employer: true) }

  describe 'Applicant can apply' do
    it 'is an applicant' do
      expect(jack.employer?).to eq(false)
    end

    it 'has no employers yet' do
      expect(User.count).to eq(2)
      expect(User.employer.count).to eq(1)
      expect(jack.employers.count).to eq(0)
    end

    it 'has an employer after applying' do
      JobApplication.create!(applicant_id: jack.id, employer_id: fountain.id)
      expect(jack.employers.first.name).to eq("Fountain")
    end
  end

  describe 'Employer has applicants' do
    it 'has no applicants to start' do
      expect(fountain.applicants.count).to eq(0)
    end

    it 'has and applicant after an applicant applies' do
      JobApplication.create!(applicant_id: jack.id, employer_id: fountain.id)
      expect(fountain.applicants.first.name).to eq("Jack")
    end
  end
end
