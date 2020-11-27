docker build -t vinothr90/multi-client:latest -t vinothr90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinothr90/multi-server:latest -t vinothr90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinothr90/multi-worker:latest -t vinothr90/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vinothr90/multi-client:latest
docker push vinothr90/multi-server:latest
docker push vinothr90/multi-worker:latest

docker push vinothr90/multi-client:$SHA
docker push vinothr90/multi-server:$SHA
docker push vinothr90/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=vinothr90/multi-server:$SHA
kubectl set image deployment/client-deployment server=vinothr90/multi-client:$SHA
kubectl set image deployment/worker-deployment server=vinothr90/multi-worker:$SHA