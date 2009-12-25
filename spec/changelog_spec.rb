# encoding: utf-8

require_relative "../lib/changelog"

describe CHANGELOG do
  before(:each) do
    path = File.join(File.dirname(__FILE__), "data.txt")
    @changelog = CHANGELOG.new(path)
  end

  describe ".new" do
    it "should raise ArgumentError if given path doesn't exist" do
      lambda { CHANGELOG.new("/a/b/c/d") }.should raise_error(ArgumentError)
    end
  end

  describe "#versions" do
    it "should returns all versions described in the CHANGELOG" do
      versions = ["Version 0.0.1 Miracle Born",
        "Version 0.1", "Version 0.1.1", "Version 0.1.2",
        "Version 0.2.0", "Version 0.2.1"]
      @changelog.versions.should eql(versions)
    end
  end

  describe "#last_version_name" do
    it "should returns name of the last version" do
      @changelog.last_version_name.should eql("Version 0.2.1")
    end
  end

  describe "#last_version_changes" do
    it "should returns changes in the last version" do
      @changelog.last_version_changes.should eql(["Cucumber Integration"])
    end
  end

  describe "#[]" do
    it "should returns changes for given version" do
      @changelog["Version 0.2.1"].should eql(["Cucumber Integration"])
    end

    it "should returns changes for given pattern if only version is matched" do
      @changelog[/Version 0.2.[12]/].should eql(["Cucumber Integration"])
    end

    it "should raise StandardError if more than one version is matched" do
      lambda { @changelog[/Version 0.2.\d/] }.should raise_error(StandardError)
    end
  end

  describe "#select" do
    it "should be able to returns {version => [changes]} hash for all the versions matching given pattern" do
      versions = ["Version 0.1", "Version 0.1.1", "Version 0.1.2"]
      @changelog.select(/^Version 0.1/).keys.should eql(versions)
    end
  end

  describe "#parse" do
    it "should be able to parse CHANGELOG to {version => [changes]}" do
      @changelog.parse.each do |key, value|
        key.should be_kind_of(String)
        value.should be_kind_of(Array)
      end
    end
  end
end
