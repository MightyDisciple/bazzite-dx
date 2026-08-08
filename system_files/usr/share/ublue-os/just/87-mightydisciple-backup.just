# Prepare BorgWarehouse access and recover a complete home. Use Vorta for
# normal backup configuration, scheduling, browsing, and restores.
[group("MightyDisciple")]
backup-key:
    /usr/libexec/mightydisciple-backup key

[group("MightyDisciple")]
restore-home:
    /usr/libexec/mightydisciple-backup restore
