module Guard
  module XctoolHelper
    TEST_FILE_REGEXP = /(Test|Spec)\.(m|mm)$/

    # Find test class from input paths.
    # 
    # - if the path is end with Test.m/Test.mm/Spec.m/Spec.mm, then it is a test class, return the class name of it
    #
    # @param [Array<String>] paths
    # @param [Array<String>] test_path
    #
    def test_classes_with_paths(paths, test_path=[])
      test_classes = paths.select{|path| path =~ TEST_FILE_REGEXP }   # get only Test/Spec
        .collect {|path| classname_with_file(path) }

      non_test_classes = paths.select{|path| path !=~ TEST_FILE_REGEXP }
        .collect {|path| test_file(path, test_path) }
        .compact
        .collect {|path| classname_with_file(path) }

      test_classes = non_test_classes + test_classes

      test_classes.uniq
    end

    # Give a file and a test path, find the test for the given file in the test path.
    # return nil if the test do not exists.
    #
    def test_file(file, test_paths=[])
      puts "find test file #{file} from #{test_paths}"

      test_paths = [] unless test_paths
      test_paths = [test_paths] unless test_paths.is_a?(Array)
      class_name = classname_with_file(file)

      # for each test path, check if we can find corresponding test file
      test_paths.each do |path|
        files = Dir.glob("#{path}/**/#{class_name}(Spec|Test).(m|mm)")
        first_file = files.first
        puts " check: #{path}/**/#{class_name}(Spec|Test).(m|mm)"

        return first_file if first_file
      end

      puts " -> not found"
      return nil
    end

    protected
    # Given a path of m or mm file, and return the class name
    def classname_with_file(path)
      path.split("/").last.gsub(/(\.(m|mm))$/, "")
    end
  end
end