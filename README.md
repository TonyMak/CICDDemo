<h2>🧐&nbsp;What is CI/CD?</h2>

<p><strong>Continuous Integration and Continuous Delivery</strong>&nbsp;is the best method for us under a frequently deployment approaches such as Agile. It can :</p>

<ol>
	<li>
	<p>Provide an&nbsp;<strong>automating procedure</strong>&nbsp;to test, build, package and release</p>
	</li>
	<li>
	<p><strong>Keep logs and versions</strong>&nbsp;of deliverable</p>
	</li>
</ol>

<h2>😍&nbsp;Why need it?</h2>

<p>Did you experience following statuation?</p>

<ol>
	<li>
	<p>New development phrase started but&nbsp;<strong>adhoc fix needed</strong>. Track back old version and apply that change to latest code base manually?</p>
	</li>
	<li>
	<p>User required a&nbsp;<strong>old version build for UAT</strong>. How to fetch old version including it&rsquo;s related old dependencies?</p>
	</li>
	<li>
	<p>Collaborate with your buddies but their&nbsp;<strong>latest change &amp; new dependencies make you crazy</strong></p>
	</li>
	<li>
	<p>and more other troublessssss</p>
	</li>
</ol>

<p>CI/CD could be really helpful to&nbsp;<strong>broost our code quality, reduce effort and risk</strong>&nbsp;to integration, and&nbsp;<strong>increase the system transparency</strong>&nbsp;within team buddies. We only need to focus on core development without facing above issues.</p>

<h2>🛠&nbsp;Tools you need</h2>

<table>
	<tbody>
		<tr>
			<th>
			<p><strong>Type</strong></p>
			</th>
			<th>
			<p><strong>Popular Tools</strong></p>
			</th>
		</tr>
		<tr>
			<th>
			<p><strong>Version Control</strong></p>
			</th>
			<td>
			<p><a href="https://github.com/">GitHub</a>,&nbsp;<a href="https://gitlab.com/">GitLab</a>,&nbsp;<a href="https://bitbucket.org/">Bitbucket</a></p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Automation Server</strong></p>
			</th>
			<td>
			<p><a href="https://www.jenkins.io/">Jenkins</a>,&nbsp;<a href="https://docs.gitlab.com/">GitLab CI/CD</a></p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Notification</strong></p>
			</th>
			<td>
			<p><a href="https://slack.com/">Slack</a>,&nbsp;<a href="https://telegram.org/">Telegram</a></p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Container</strong></p>
			</th>
			<td>
			<p><a href="https://www.docker.com/">Docker</a>,&nbsp;<a href="https://kubernetes.io/">Kubernetes</a></p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Repository</strong></p>
			</th>
			<td>
			<p><a href="https://appcenter.ms/">App Center</a>,&nbsp;<a href="https://www.sonatype.com/products/nexus-repository">Nexus</a></p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Others</strong></p>
			</th>
			<td>
			<p><a href="https://www.checkpoint.com/cyber-hub/cloud-security/what-is-runtime-application-self-protection-rasp/">RASP</a>,&nbsp;<a href="https://www.sonarqube.org/">Sonarqube</a></p>
			</td>
		</tr>
	</tbody>
</table>

<h2>📍&nbsp;Flow Overview</h2>

<p>Above is&nbsp;<strong>normal flow</strong>&nbsp;which could be applied to most of the scence. However, the magic of Jenkins is&nbsp;<strong>fully flexible that you could customise</strong>&nbsp;the own stage you need.</p>

<p>For example, we might add RASP checking before Step.10, to protect our application away from risk. All CI/CD stage could be configurated in config. file.</p>

<h2>🛠&nbsp;Concept &amp; Terms</h2>

<table>
	<tbody>
		<tr>
			<th>
			<p><strong>Agent</strong></p>
			</th>
			<td>
			<p>A machine / container for build task</p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Pipelines</strong></p>
			</th>
			<td>
			<p>Queue for our CI/CD cycle to be structured &amp; processed</p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>CI/CD variables</strong></p>
			</th>
			<td>
			<p>Variables that affect build target &amp; favourite in config file</p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Environments</strong></p>
			</th>
			<td>
			<p>Deploy application to different env. such as UAT, SIT, PROD</p>
			</td>
		</tr>
		<tr>
			<th>
			<p><strong>Artifacts</strong></p>
			</th>
			<td>
			<p>Bundle for storing build / pipeline information such as build &amp; test log</p>
			</td>
		</tr>
	</tbody>
</table>

<p>Above is common concept as starter. Terms similar between different automation platforms, to know more in&nbsp;<a href="https://www.jenkins.io/doc/book/glossary/">Jenkins&#39; glossary</a>.</p>

<h2>⚙&nbsp;Sample Project (Jenkins)</h2>

<p><a href="https://github.com/TonyMak/cicddemo">GitHub CICD Demo</a><br />
- Jenkinsfile<br />
- BuildScript</p>

<h2>📍&nbsp;Q&amp;A</h2>

<p>TBC</p>

<h2>📖&nbsp;Reference</h2>

<ol>
	<li>
	<p>CI/CD diagram source (Attachment)</p>
	</li>
	<li>
	<p><a href="https://www.jenkins.io/doc/book/getting-started/">Jenkin handbook</a></p>
	</li>
</ol>

<p>&nbsp;</p>

<h2>&nbsp;</h2>
