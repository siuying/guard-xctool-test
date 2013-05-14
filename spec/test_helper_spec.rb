require 'spec_helper'

describe "Guard::Xctool::TestHelper" do
  subject {
    object = Object.new
    object.send :extend, Guard::Xctool::TestHelper
  }
  describe "::test_classes_with_paths" do
    it "should return list of file name that ends with Spec or Test" do
      files  = ["ProjectTests/A/B/C/File1Test.m", "ProjectTests/A/B/C/File2Spec.m", "Project/A/B/C/File3.h", "Project/A/B/C/File2.m"]
      test_files = subject.test_classes_with_paths(files, "ProjectTests")
      test_files.should be_include("File1Test")
      test_files.should be_include("File2Spec")
      test_files.should_not be_include("File2")
      test_files.should_not be_include("File3")
    end

    it "should return test file of non-test classes" do
      # mock glob op, pretent we have File3Spec on disk
      Dir.stub(:glob).and_return(["ProjectTests/A/File3Spec.m"])

      files  = ["ProjectTests/A/B/C/File1Test.m", "ProjectTests/A/B/C/File2Spec.m", "Project/A/B/C/File3.h", "Project/A/B/C/File2.m"]
      test_files = subject.test_classes_with_paths(files, "ProjectTests")
      test_files.should be_include("File1Test")
      test_files.should be_include("File2Spec")
      test_files.should be_include("File3Spec")
      test_files.should_not be_include("File2")
      test_files.should_not be_include("File3")
    end
  end

  describe "::test_file" do 
    it "should return test file if one exists" do
      Dir.stub(:glob).and_return(["ProjectTests/A/MyFileSpec.m"])
      test_file = subject.test_file("Project/A/MyFile.m", "ProjectTests")
      test_file.should == "MyFileSpec"
    end

    it "should return nil if one does not exists" do
      Dir.stub(:glob).and_return([])
      test_file = subject.test_file("Project/A/MyFile.m", "ProjectTests")
      test_file.should_not == "MyFileSpec"
    end
  end
end