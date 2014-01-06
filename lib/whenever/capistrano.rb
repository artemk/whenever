require "whenever/capistrano/recipes"

Capistrano::Configuration.instance(:must_exist).load do
  # Write the new cron jobs near the end.
  # Can be set multiple hooks like {[[:before, "deploy:finalize_update"] , [:after, "deploy:rollback"]]}
  _cset(:whenever_update_crontab_hook) {[[:before, "deploy:finalize_update"]]}

  fetch(:whenever_update_crontab_hook).each do |_when, _what|
    #before "deploy:finalize_update", "whenever:update_crontab"
    self.send(_when.to_sym, _what, "whenever:update_crontab")
  end

  # If anything goes wrong, undo.
  after "deploy:rollback", "whenever:update_crontab"
end
