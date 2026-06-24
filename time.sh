#!/bin/bash

# Ask for login time
echo "When did you login? Format: HH:MM"
echo "Example: For 9 AM, enter 09:00"
read -p "Enter login time: " LOGIN

# Split HH and MM
HOUR=$(echo $LOGIN | cut -d: -f1)
MIN=$(echo $LOGIN | cut -d: -f2)

# Convert to total minutes
TOTAL_MIN=$((10#$HOUR * 60 + 10#$MIN))

# Add 8.5 hours = 8*60 + 30 = 510 minutes
LOGOUT_MIN=$((TOTAL_MIN + 510))

# Convert back to hours-minutes
LOGOUT_HOUR=$((LOGOUT_MIN / 60))
LOGOUT_MIN_REM=$((LOGOUT_MIN % 60))

# If it goes past 24 hours, show next day
if [ $LOGOUT_HOUR -ge 24 ]; then
    LOGOUT_HOUR=$((LOGOUT_HOUR - 24))
    DAY="+1 day"
else
    DAY=""
fi

# Print in 2-digit format
printf "\n✅ Login time: %02d:%02d\n" $HOUR $MIN
printf "🚪 Logout time: %02d:%02d %s\n" $LOGOUT_HOUR $LOGOUT_MIN_REM "$DAY"
echo "8.5 hours will be completed at this time"
