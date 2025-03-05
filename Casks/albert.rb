cask "albert" do
  arch arm: "arm64", intel: "x86-64"

  # Dont touch, updated by github action
  version "0.27.4"
  sha256 arm: "61a98f4572f03ab9fe6dbe73cb617f5230c8cb918716634eb69deee3c79d6757", intel: "8d2920e255be1fd3acd80a68c4f1dcdf43deb19c27bd03497e3c1ffe530758c3"

  url "https://github.com/albertlauncher/albert/releases/download/v#{version}/Albert-v#{version}-#{arch}.dmg",
      verified: "github.com/albertlauncher/albert/"
  name "Albert"
  desc "Plugin-based keyboard launcher"
  homepage "https://albertlauncher.github.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"
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
