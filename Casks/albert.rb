cask "albert" do
  arch arm: "arm64", intel: "x86_64"

  # Dont touch, updated by github action
  version "35.2.0"
  sha256 arm: "4882d2341b9da61d97c522096cf3814976dbdea8930f136454b61176b646b0d8", intel: "10dbf361cda990909f4bd08eb08884fc52920376a0940d85556e222be96ddae3"

  url "https://github.com/albertlauncher/albert/releases/download/v#{version}/Albert-v#{version}-#{arch}.dmg"
  name "Albert"
  desc "Plugin-based keyboard launcher"
  homepage "https://albertlauncher.github.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos
  depends_on formula: "qt6"
  depends_on formula: "libqalculate"
  depends_on formula: "qtkeychain"
  depends_on formula: "qcoro6"

  app "Albert.app"

  postflight_steps do

    run "/usr/bin/xattr",
        args: ["-d", "com.apple.quarantine", "{{appdir}}/Albert.app"],
        must_succeed: false

    run "/usr/bin/codesign",
        args: ["--force", "--deep", "--sign", "-", "{{appdir}}/Albert.app"]

  end

  caveats <<~EOS
    Note that this bundle is not selfcontained, but rather uses shared libraries provided by homebrew.
    Also plugins may introduce additional dependencies you may have to install using homebrew.
    E.g. the calculator requires libqalculate: Install it, restart Albert and enable the plugin.
  EOS

  caveats do
    unsigned_accessibility
  end

end
