/*

    toggleFormState(checkbox, form, foldingForm = false, customToggle)
  
    - Toggles form interactivity and UI styling based on checkbox state
    - Adds/removes "form-disabled" and optional "folded" class to the form
    - Disables/enables all inputs inside the form except the checkbox
    - Applies "disabled" class to child elements matched by customToggle selector
    - Scrolls unfolded form into view if foldingForm is true

    usage example :
        <script src="/JS/toggleForms.js"></script>
        <script>
            // toggling input fields
            document.querySelectorAll("legend input").forEach(checkbox => {
                const form = el.closest("fieldset");
                const isFoldingForm = fieldset.classList.contains("UserPI");

                toggleFormState(checkbox, form, isFoldingForm, ".custom-dropdowns");
                el.addEventListener("change", () => toggleFormState(checkbox, form, isFoldingForm, ".custom-dropdowns"));
            });
        </script>

 */


function toggleFormState(checkbox, form, foldingForm = false, customToggle) {
    const disabled = !checkbox.checked;
    form.classList.toggle("form-disabled", disabled);
    if (foldingForm)
        form.classList.toggle("folded", disabled);
    if (customToggle)
        form.querySelectorAll(customToggle).forEach(dropdown => {
            dropdown.classList.toggle("disabled", disabled);
        });

    let scrollTimeout;
    if (!disabled && foldingForm) {
        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(() => {
            form.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 300);
    }

    Array.from(form.querySelectorAll("input, select, textarea, button")).forEach(el => {
        if (el !== checkbox)
            el.disabled = disabled;
    });
};