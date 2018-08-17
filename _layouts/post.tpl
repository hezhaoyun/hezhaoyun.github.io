---
layout: page
class: page-type-post
---

<div class="trace">/ <a href="/">{{ site.name }}</a> / {{ page.title }}</div>

<article>
	<h1><a href="{{ page.url }}">{{ page.title }}</a></h1>
	{% assign post = page %}
	{% include meta.tpl %}
	{{ content }}
	{% capture permaurl %}http://{{site.host}}{{ page.url }}{% endcapture %}
	<!-- <p class="permalink">永久链接：<a href="{{ permaurl }}">{{ permaurl }}</a></p> -->
</article>
<div id="disqus_thread" class="comments"></div>
<script>
	var disqus_config = function () {
		this.page.url = 'http://{{ site.host }}{{ page.url }}';
		this.page.identifier = 'http://{{ site.host }}{{ page.url }}';
	};
	(function () { // DON'T EDIT BELOW THIS LINE
		var d = document, s = d.createElement('script');
		s.src = 'https://hezhaoyun-github-io.disqus.com/embed.js';
		s.setAttribute('data-timestamp', +new Date());
		(d.head || d.body).appendChild(s);
	})();
</script>
