function aws-mfa-clear
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN

    echo "AWS session credentials cleared."
end
