require 'spec_helper'

describe Swearjar do
  it "should detect dirty words" do
    expect(Swearjar.default.profane?('fuck you jim henson')).to be_truthy
  end

  it "should detect dirty words regardless of case" do
    expect(Swearjar.default.profane?('FuCk you jim henson')).to be_truthy
  end

  it "should not detect non-dirty words" do
    expect(Swearjar.default.profane?('i love you jim henson')).to be_falsey
  end

  it "should give us a scorecard" do
    expect(Swearjar.default.scorecard('fuck you jim henson')).to eq({'sexual'=>1})
  end

  it "should detect multiword" do
    expect(Swearjar.default.scorecard('jim henson has a hard on')).to eq({'sexual'=>1})
  end

  it "should detect multiword plurals" do
    expect(Swearjar.default.scorecard('jim henson has a hard ons')).to eq({'sexual'=>1})
  end

  it "should detect simple dirty plurals" do
    expect(Swearjar.default.profane?('jim henson had two dicks')).to be_truthy
    expect(Swearjar.default.profane?('jim henson has two asses')).to be_truthy
  end

  it "should censor a string" do
    expect(Swearjar.default.censor('jim henson has a massive hard on he is gonna use to fuck everybody')).to eq('jim henson has a massive **** ** he is gonna use to **** everybody')
  end

  it "should not do much when given a non-string" do
    expect(Swearjar.default.profane?(nil)).to be_falsey
  end

  it "doesn't mark an empty string as profane" do
    expect(Swearjar.default.profane?("")).to be_falsey
  end

  it "should allow you to load a new yaml file" do
    sj = Swearjar.new
    sj.load_file(File.expand_path('../data/swear.yml', __FILE__))
    expect(sj.censor("Python is the best language!")).to eq("****** is the best language!")
  end
end
