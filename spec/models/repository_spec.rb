require 'spec_helper'

describe Repository do
  let!(:repo) {Fabricate.build(:first_repo)}

  subject { repo }

  it { should have_field(:github_id).of_type(String) }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:owner).of_type(String) }
  it { should have_field(:description).of_type(String) }
  it { should have_field(:stars).of_type(Integer) }
  it { should have_field(:forks).of_type(Integer) }
  it { should have_field(:public).of_type(Boolean) }
  it { should have_field(:updated_at).of_type(DateTime) }

  it { should validate_presence_of(:github_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should validate_uniqueness_of(:github_id) }

end
