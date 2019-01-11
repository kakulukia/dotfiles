minikube start --memory=11264 --bootstrapper=kubeadm
kubectl config use-context minikube
eval $(minikube docker-env)
