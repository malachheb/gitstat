require 'spec_helper'

describe Commiter do
  let!(:committer) {Fabricate.build(:testeur1)}

  subject { committer }

  it { should have_field(:github_id).of_type(String) }
  it { should have_field(:login).of_type(String) }
  it { should have_field(:gravatar_id).of_type(String) }
  it { should have_field(:contributions).of_type(Integer) }

  it { should validate_presence_of(:github_id) }
  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:github_id) }
  it { should validate_uniqueness_of(:login) }

end
