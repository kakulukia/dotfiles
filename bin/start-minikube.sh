minikube start --memory=8192 --bootstrapper=kubeadm

kubectl config get-contexts
kubectl config use-context minikube
eval $(minikube docker-env)
