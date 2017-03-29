$(function() {
  var parent = $('.helmet-gallery');
  var container = parent.find('.gallery-container');
  var thumbs = parent.find('.thumb');
  thumbs.first().addClass('selected');
  thumbs.click(function(e) {
    thumbs.removeClass('selected');
    var index = thumbs.index(this);
    thumbs.eq(index).addClass('selected');
    container.css('transform', 'translate('+ (-100 * index) +'%)');
  });
});