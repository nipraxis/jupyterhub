# Setup for Nipraxis JupyterHub

* Open [Google Cloud web console](https://console.cloud.google.com), and start
  the web shell, or install the [Google Cloud
  SDK](https://cloud.google.com/sdk) locally.
* If not done already: `git clone nipraxis/jupyterhub nipraxis-jupyterhub`
* `cd nipraxis-jupyterhub`
* If starting from scratch see: "The whole thing" section in `./notes.md`.
* If resuming: `source setup_helm.sh`
* To apply changes in `config.yaml` to running instance: `./rehelm.sh`.
* See other scripts in repo directory for setup / teardown utilities.

See `./notes.md` for description and other procedure.
