cask "albert" do
  arch arm: "arm64", intel: "x86_64"

  # Dont touch, updated by github action
  version "0.28.1"
  sha256 arm: "22921070e4f9582f37ccad54c68d2b8067debf9144455930ea57a7491db0e5be", intel: "b2e596cefa1a39df2d50fa3b0136cd1c892f3f864e1aa0eee0d729e9a51f0590"

  url "https://github.com/albertlauncher/albert/releases/download/v#{version}/Albert-v#{version}-#{arch}.dmg",
      verified: "github.com/albertlauncher/albert/"
  name "Albert"
  desc "Plugin-based keyboard launcher"
  homepage "https://albertlauncher.github.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :catalina"
  depends_on formula: "qt6"
  depends_on formula: "libqalculate"

  app "Albert.app"

  postflight do

    system_command "xattr",
             args: ["-d", "com.apple.quarantine", "/Applications/Albert.app"]

    system_command "/usr/bin/codesign",
             args: ["--force", "--deep", "--sign", "-", "/Applications/Albert.app"]

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
