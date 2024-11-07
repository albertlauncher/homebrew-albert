cask "albert" do
 # arch arm: "12-m1", intel: "10"

  version "0.26.4"
  sha256 :no_check
  #sha256 arm:   "dfbed21dbc117116d12d5200bf51f5d3bd358052b7d17c350fa1f6828f0e9647",
  #       intel: "dfbed21dbc117116d12d5200bf51f5d3bd358052b7d17c350fa1f6828f0e9647"

  url "https://github.com/albertlauncher/albert/releases/download/v#{version}/Albert-v#{version}.dmg",
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

  caveats <<~EOS
    Note that this bundle is not selfcontained, but rather uses shared libraries provided by homebrew.
    Also plugins may introduce additional dependencies you may have to install using homebrew.
    E.g. the calculator requires libqalculate: Install it, restart Albert and enable the plugin.
  EOS

end
