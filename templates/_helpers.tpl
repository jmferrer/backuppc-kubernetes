{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper BackupPC image name
*/}}
{{- define "backuppc.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "backuppc.volumePermissions.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.volumePermissions.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "backuppc.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.volumePermissions.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backuppc.customHTAccessCM" -}}
{{- printf "%s" .Values.customHTAccessCM -}}
{{- end -}}

{{/*
Return the BackupPC configuration secret
*/}}
{{- define "backuppc.configSecretName" -}}
{{- if .Values.existingBackupPCConfigurationSecret -}}
    {{- printf "%s" (tpl .Values.existingBackupPCConfigurationSecret $) -}}
{{- else -}}
    {{- printf "%s-configuration" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created for WordPress configuration
*/}}
{{- define "backuppc.createConfigSecret" -}}
{{- if and .Values.backuppcConfiguration (not .Values.existingBackupPCConfigurationSecret) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the WordPress Secret Name
*/}}
{{- define "backuppc.secretName" -}}
{{- if .Values.existingSecret }}
    {{- printf "%s" .Values.existingSecret -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the SMTP Secret Name
*/}}
{{- define "backuppc.smtpSecretName" -}}
{{- if .Values.smtpExistingSecret }}
    {{- printf "%s" .Values.smtpExistingSecret -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "backuppc.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "backuppc.validateValues.configuration" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}
{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Validate values of BackupPC - Custom config.pl
*/}}
{{- define "backuppc.validateValues.configuration" -}}
{{- if or .Values.backuppcConfiguration .Values.existingBackupPCConfigurationSecret -}}
backuppc: backuppcConfiguration
    Using provided config.pl configuration.
{{- end -}}
{{- end -}}
