def report_xcode_summary(platform:)
    path = "#{ENV["IOS_BUILD_LOG_PATH"]}.xcresult"
    xcode_summary.report(path)
end

warn('This pull request is marked as Work in Progress. DO NOT MERGE!') if github.pr_title.include? "[WIP]"

swiftlint.lint_all_files = true
swiftlint.lint_files(fail_on_error: true, inline_mode: true)

report_xcode_summary(platform: "iOS")
