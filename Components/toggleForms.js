/*

    toggleFormState(checkbox, form, foldingForm = false, customToggle)
  
    - Toggles form interactivity and UI styling based on checkbox state
    - Adds/removes "form-disabled" and optional "folded" class to the form
    - Disables/enables all inputs inside the form except the checkbox
    - Applies "disabled" class to child elements matched by customToggle selector
    - Scrolls unfolded form into view if foldingForm is true

    usage example :
        <script src="/Components/toggleForms.js"></script>
        <script>
            // toggling input fields
            document.querySelectorAll("toggle-element").forEach(el => {
                const form = el.closest(".form-field"); // similar to queryselector, it retrieves the colosest parent element in acccording to the query
                const isFoldingForm = form.classList.contains("FoldingForm");
                const isCustomForm = form.classList.contains("CustomForm");
                if (isCustomForm) {
                    form.disable = () => disableDDLs(form); // you can use this to retrieve the element and do element.disable() because form's default reset() wont effect a custom form
                    form.toggle = () => toggleDDLs(form);
                }
                toggleFormState(el, form, isFoldingForm, isCustomForm);
                el.addEventListener("change", () => toggleFormState(el, form, isFoldingForm, isCustomForm));
            });        
        </script>

 */


function toggleFormState(checkbox, form, foldingForm = false, customForm = false) {
    form.dispatchEvent(new CustomEvent("toggled!"));
    const disabled = !checkbox.checked;
    if (disabled) {
        checkbox.checked = false;
    }
    form.classList.toggle("form-disabled", disabled);
    if (foldingForm)
        form.classList.toggle("folded", disabled);
    if (customForm)
        form.toggle(disabled);

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