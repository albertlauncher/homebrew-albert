cask "albert" do
  arch arm: "arm64", intel: "x86_64"

  # Dont touch, updated by github action
  version "34.0.10"
  sha256 arm: "323e1ef0c1f6d23558585ba1b6cffaa32dadbc2e9646ca36dd8a4fe9bbf5d971", intel: "415dac86faaf7453ddaab71f5148e07d876ffff4d6674f1adaf0962c06e9cdf8"

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
  depends_on formula: "qtkeychain"

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
