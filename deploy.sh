docker build -t reboxyz/multi-client:latest -t reboxyz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t reboxyz/multi-server:latest -t reboxyz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t reboxyz/multi-worker:latest -t reboxyz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push reboxyz/multi-client:latest
docker push reboxyz/multi-server:latest
docker push reboxyz/multi-worker:latest

docker push reboxyz/multi-client:$SHA
docker push reboxyz/multi-server:$SHA
docker push reboxyz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=reboxyz/multi-server:$SHA
kubectl set image deployments/client-deployment client=reboxyz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=reboxyz/multi-worker:$SHA


