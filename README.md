README

You can see the step by step guide by following the link below:
[🌥️ Moving data between GCP projects/buckets 🌐](https://cc3c84e8.dominikjaro.pages.dev/p/%EF%B8%8F-moving-data-between-gcp-projects/buckets/)

Scripts that allow for the seeding of application data from a source project to a new empty project.

This `bootstrap/seed-data` location includes the following files:

* `seed-bigquery.sh`, allowing the copy of all datasets in one BigQuery project to be copied to another
* `seed-gcs.sh`, copies GCS bucket data for empty datasets in the new project from the equivalent buckets in the source project
* `seed-datastore`, imports data into Datastore from a snapshot that exists (and is refreshed outside of this code) in the GCP-source project

Use a `make` with any of the following targets and the destination project name as the `destination` argument
* `all` (each of the targets below), this is also the default target
* `seed-bigquery`
* `seed-gcs`
* `see-datastore`

e.g. `make all destination=[destination-project]` **Note:** Add your destination project 
