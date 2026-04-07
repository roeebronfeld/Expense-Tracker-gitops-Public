{{/*
Common labels
*/}}
{{- define "apps.labels" -}}
app.kubernetes.io/managed-by: argocd
app.kubernetes.io/part-of: expense-tracker
{{- if .Values.environment }}
app.kubernetes.io/environment: {{ .Values.environment }}
{{- end }}
{{- end }}

{{/*
Environment suffix for application names (single prod environment - no suffix needed)
*/}}
{{- define "apps.envSuffix" -}}
{{- end }}

{{/*
Common sync policy
*/}}
{{- define "apps.syncPolicy" -}}
automated:
  prune: true
  selfHeal: true
syncOptions:
  - CreateNamespace=true
  - ServerSideApply=true
  - RespectIgnoreDifferences=true
retry:
  limit: 5
  backoff:
    duration: 5s
    factor: 2
    maxDuration: 3m
{{- end }}
