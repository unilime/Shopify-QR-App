#!/usr/bin/env bash
docker build --build-arg SHOPIFY_API_KEY=$1 -t shopify_qr_app .

docker container stop shopify_qr_app

docker run -d --rm --name shopify_qr_app -e SHOPIFY_API_KEY=$1 -e SHOPIFY_API_SECRET=$2 -e SCOPES="write_products,read_discounts" -e HOST=https://shopify.example.com -e BACKEND_PORT="8081" --volume $PWD/web/database.sqlite:/app/database.sqlite -p 8081:8081 shopify_qr_app

docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
