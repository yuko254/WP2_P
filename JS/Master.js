function clearForm() {
    const form = document.querySelector("#form1");
    form.querySelectorAll("input, select, textarea").forEach(el => {
        if (el.type === "checkbox" || el.type === "radio") {
            el.checked = false;
        } else if (el.type === "button" || el.type === "submit") {
            return;
        }
        else {
            el.value = "";
        }
    });
    console.log("form manually cleared");
}