# macOS 系统偏好：用户、Shell、Finder、Dock
{ pkgs, username, ... }:
{
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  # 确保 fish 被设为默认 Shell（dscl 方式）
  system.activationScripts.setDefaultShell.text = ''
    fish=/run/current-system/sw/bin/fish
    current=$(dscl . -read /Users/${username} UserShell 2>/dev/null | awk '{print $2}')
    if [ "$current" != "$fish" ]; then
      echo "Setting default shell for ${username} to fish"
      dscl . -create /Users/${username} UserShell "$fish"
    fi
  '';

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
    };
    dock = {
      autohide = true;
      persistent-apps = [
        "/System/Applications/System Settings.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/iPhone Mirroring.app"
        "/Applications/Nix Apps/Ghostty.app"
        "/Applications/Google Chrome.app"
        "/Applications/Notion.app"
        "/Applications/Sublime Text.app"
        "/Applications/Zed.app"
        "/Applications/Orbstack.app"
        "/Applications/App Cleaner 9.app"
      ];
      wvous-tr-corner = 1;
      wvous-tl-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
    };
    NSGlobalDomain = {
      NSWindowShouldDragOnGesture = true;
      NSAutomaticWindowAnimationsEnabled = false;
    };
  };
}
