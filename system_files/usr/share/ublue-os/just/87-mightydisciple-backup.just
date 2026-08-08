# Back up and restore a complete user home with BorgWarehouse/Borg.
[group("MightyDisciple")]
backup-setup:
    /usr/libexec/mightydisciple-backup setup

[group("MightyDisciple")]
backup-now:
    /usr/libexec/mightydisciple-backup create

[group("MightyDisciple")]
backup-list:
    /usr/libexec/mightydisciple-backup list

[group("MightyDisciple")]
backup-check:
    /usr/libexec/mightydisciple-backup check

[group("MightyDisciple")]
restore-home:
    /usr/libexec/mightydisciple-backup restore
