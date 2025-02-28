cask "albert" do
  arch arm: "arm64", intel: "x86-64"

  # Dont touch, updated by github action
  version "0.27.2"
  sha256 arm: "ea024978e905e542021015e6f1ce735960badac47212af532b46099f4f152009", intel: "10860f3abcc042360f94efa187d09daed9a99e5872466ad6ee105b8da250dbf0"

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
