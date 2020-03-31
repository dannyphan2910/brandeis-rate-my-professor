import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const renderItem = function (item) {
    return `<div class="autocomplete-suggestion"><span>${item}</span></div>`
};

const autocompleteSearch = function() {
  const searchInput = document.getElementById('term');
  console.log("im here")
  if (searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term){
        $.getJSON('/courses',
          { term: term },
          function(data) {
            return data;
        })
      },
      renderItem: renderItem,
    });
  }
};

export { autocompleteSearch };