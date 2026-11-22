/** Shared web client. Each app keeps its own UI and sends to the central project. */
export async function sendFeedback({ endpoint = 'https://sw-studio-feedback.antqueue.workers.dev/', appId, message, type = 'general', name = '', email = '', appVersion = '', platform = 'web' }) {
  if (!endpoint || new URL(endpoint).protocol !== 'https:') throw new Error('Configure the HTTPS feedback Worker URL.');
  const response = await fetch(endpoint, {
    method: 'POST', headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ appId, message, type, name, email, appVersion, platform,
      pageUrl: platform === 'web' && globalThis.location ? location.origin + location.pathname : '' })
  });
  const result = await response.json();
  if (!response.ok) throw new Error(result.error || 'Feedback could not be sent.');
  return result.id;
}
