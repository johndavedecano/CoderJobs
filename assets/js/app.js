$(() => {
  $('.delete-button').on('click', function(e) {
    e.preventDefault();
    confirm = window.confirm('Are you sure you want to delete this item?');
    if (confirm) {
      window.location.href = e.target.getAttribute('href');
    }
  });
});
