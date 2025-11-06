az storage blob list \
  --account-name wasdpeus2abakmi55352 \
  --container-name bkpmi-sqlmi-pw-etl-db1-eas-0f42c321-ab56-43a4-8389-304627b6d892 \
  --output table


az storage blob list \
  --account-name wasdpeus2abakmi55352-secondary \
  --container-name backup \
  --output table


  azcopy copy \
  "https://wasdpeus2abakmi55352.blob.core.windows.net/<same-path>/<..._S2_0.log>?<SAS>" \
  "https://wasdpeus2abakmi55352-secondary.blob.core.windows.net/<same-path>/<..._S2_0.log>?<SAS>"

