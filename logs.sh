# Ver logs de cada pod
for pod in $(kubectl get pods -n $1 -o jsonpath='{.items[*].metadata.name}'); do
  echo "=== Logs do pod $pod ==="
  kubectl logs $pod -n $1
  echo -e "\n\n"
done