cask "albert" do
  arch arm: "arm64", intel: "x86_64"

  # Dont touch, updated by github action
  version "34.0.1"
  sha256 arm: "3029d7a73900d3fd3e6a0e5ec9d67b9f10a177b3a29f8af69baa028d8f6f9ced", intel: "54b3c6b0d627c2386bb0a02f0cfee541c125ea76f8fb7e501655c87f5fabdb79"

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
