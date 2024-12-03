SRC_PROJECT=[GCP_PROJECT_ID] # Add your source project id

.PHONY:all
all: seed-datastore seed-gcs seed-bigquery

.PHONY:seed-datastore
seed-datastore: check
		./seed-datastore.sh ${destination}

.PHONY:seed-gcs
seed-gcs: check
		./seed-gcs.sh ${SRC_PROJECT} ${destination}

.PHONY:seed-bigquery
seed-bigquery: check
		./seed-bigquery.sh ${SRC_PROJECT} ${destination}

.PHONY:check
check:
		@[ "${destination}" ] && echo "Destination project: ${destination}" || ( echo "destination project is not set"; exit 1 )

