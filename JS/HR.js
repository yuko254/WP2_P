// Random password generating
function generate_password() {
    const RandPass = document.querySelector("#ContentPlaceHolder1_account_Pass_Input");
    const allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    let arr = new Array(10).fill('').map(() => allowedChars[Math.floor(Math.random() * allowedChars.length)]);
    RandPass.value = arr.join('');
};

// custom form border color change on input/ineraction
document.querySelectorAll(".animated-input, select").forEach(input => {
    const container = input.closest(".container");

    const updateContainerState = () => {
        if (document.activeElement === input || input.value.trim() !== "") {
            container.style.borderColor = "rgb(255, 106, 0)";
        } else {
            container.style.borderColor = "#ccc"; // fallback to default
        }
    };

    container.addEventListener("toggled!", updateContainerState);
    input.addEventListener("change", updateContainerState);
    input.addEventListener("focus", updateContainerState);
    input.addEventListener("blur", updateContainerState);
    input.addEventListener("input", updateContainerState);
});





window.addEventListener("DOMContentLoaded", () => {
    setTimeout(() => {
        document.querySelectorAll(".UserPI, .UserPI.folded legend ~ *").forEach(el => {
            el.style.transition = "max-height 1s ease 0s, transform 0.5s ease-out 1s, opacity 0.5s ease 0s";
        });
    }, 2000);

    // toggling input fields
    document.querySelectorAll("legend input").forEach(el => {
        const fieldset = el.closest("fieldset");
        const isUserPI = fieldset.classList.contains("UserPI");
        const isUserPosition = fieldset.classList.contains("UserPosition");
        if (isUserPosition) {
            fieldset.disable = () => disableDDLs(fieldset);
            fieldset.toggle = (disabled) => toggleDDLs(fieldset, disabled);
        }
        toggleFormState(el, fieldset, isUserPI, isUserPosition);
        el.addEventListener("change", () => toggleFormState(el, fieldset, isUserPI, isUserPosition));
    });

    // 
    function cancelUserPo() {
        const cancelBtn = [...document.querySelectorAll('[id]')].find(el => el.id.endsWith('Cancel_CreateAccount'));
        cancelBtn?.addEventListener("click", () => {
            clearForm();
            document.querySelectorAll("legend input").forEach(input => {
                const fieldset = input.closest("fieldset");
                const isUserPosition = fieldset.classList.contains("UserPosition");
                if (isUserPosition)
                    fieldset.disable();
                else
                    input.dispatchEvent(new Event("change"));
            });
            console.log("cancel clicked!")
        });
    };
    cancelUserPo();
});
