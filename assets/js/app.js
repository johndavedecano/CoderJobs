$(() => {
  // Handle all delete buttons confirmation
  $(".delete-button").on("click", function(e) {
    e.preventDefault();
    confirm = window.confirm("Are you sure you want to delete this item?");
    if (confirm) {
      window.location.href = e.target.getAttribute("href");
    }
  });

  if ($("#editor").length > 0) {
    // Initialize text editor
    const quill = new Quill("#editor", {
      placeholder: "Compose an epic...",
      theme: "snow", // or 'bubble'
    });

    quill.on("text-change", () => {
      $("#editor_hidden").val(quill.container.firstChild.innerHTML);
    });
  }
});
