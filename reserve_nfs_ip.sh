# https://cloud.google.com/compute/docs/ip-addresses/reserve-static-internal-ip-address#gcloud_1
gcloud compute addresses create nfs-service-address \
        --addresses 10.128.4.90,10.128.0.232 \
            --region us-central1 \
                --subnet subnet-1
