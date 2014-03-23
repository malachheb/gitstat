require 'spec_helper'

describe Commit do
  let!(:commit) {Fabricate.build(:first_commit)}

  subject { commit }

  it { should have_field(:sha).of_type(String) }
  it { should have_field(:date).of_type(DateTime) }
  it { should have_field(:message).of_type(String) }
  it { should have_field(:committer).of_type(String) }
  it { should have_field(:additions).of_type(Integer) }
  it { should have_field(:deletions).of_type(Integer) }

  it { should validate_presence_of(:sha) }
  it { should validate_presence_of(:date) }

end
