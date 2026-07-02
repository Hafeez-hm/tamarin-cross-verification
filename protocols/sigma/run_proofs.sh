#!/usr/bin/env bash

LEMMAS=(
    "executable"
    "agreement_strict_A_to_B"
    "session_key_secrecy_A"
    "session_key_secrecy_B"
    "agreement_B_to_A"
    "agreement_A_to_B"
)


NO_COL_FILE=$(ls | grep "no_collision.spthy" | head -n 1)
COL_FILE=$(ls | grep "collision.spthy" | head -n 1)
SUMMARY_FILE="summary.res"


echo "==========================================================" > "$SUMMARY_FILE"
echo "        Tamarin Protocol Verification Summary Results     " >> "$SUMMARY_FILE"
echo "==========================================================" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

clear
echo "=========================================================="
echo " Starting Automated Tamarin Lemma Execution Suite"
echo "=========================================================="

# Ensure the tamarin-prover binary is available on the path environment
if ! command -v tamarin-prover &> /dev/null; then
    echo "Error: tamarin-prover binary not detected on current PATH."
    exit 1
fi

# Evaluate the No-Collision Model
if [ ! -z "$NO_COL_FILE" ]; then
    echo "Processing No-Collision Model: $NO_COL_FILE"
    echo "--- Model: $NO_COL_FILE ---" >> "$SUMMARY_FILE"
    
    for lemma in "${LEMMAS[@]}"; do
        echo -n "  -> Proving Lemma: $lemma... "
        OUTPUT=$(tamarin-prover "$NO_COL_FILE" --prove="$lemma" 2>&1)
        
        if echo "$OUTPUT" | grep -q "verified"; then
            echo "VERIFIED"
            echo "  [PASS] $lemma: VERIFIED" >> "$SUMMARY_FILE"
        else
            echo "FALSIFIED"
            echo "  [FAIL] $lemma: FALSIFIED" >> "$SUMMARY_FILE"
        fi
    done
    echo "" >> "$SUMMARY_FILE"
fi

echo "----------------------------------------------------------"

# Evaluate the Active Collision Model
if [ ! -z "$COL_FILE" ]; then
    echo "Processing Collision Model: $COL_FILE"
    echo "--- Model: $COL_FILE ---" >> "$SUMMARY_FILE"
    
    for lemma in "${LEMMAS[@]}"; do
        echo -n "  -> Proving Lemma: $lemma... "
        OUTPUT=$(tamarin-prover "$COL_FILE" --prove="$lemma" 2>&1)
        
        if echo "$OUTPUT" | grep -q "verified"; then
            echo "VERIFIED"
            echo "  [PASS] $lemma: VERIFIED" >> "$SUMMARY_FILE"
        else
            echo "FALSIFIED"
            echo "  [FAIL] $lemma: FALSIFIED" >> "$SUMMARY_FILE"
        fi
    done
fi

echo "=========================================================="
echo " Verification Complete. Summary saved to: ./$SUMMARY_FILE"
echo "=========================================================="