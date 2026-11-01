# Axon Remote privacy policy

Axon Remote (the iPhone app and the `axon` command for macOS) is an invite-only beta run by Tyr Chen. It lets
you follow and drive coding-agent sessions (Claude Code, Codex and others) on your own Macs.

## What is stored

- Your Google account email, used to sign in.
- Your paired Macs' names and versions, and your phones' public signing keys and push tokens.
- Session titles, folders and status. While a Mac is in Remote mode (or set to sync while local): the
  conversation, the terminal screen and text you relay between sessions.
- An audit log of what your phones asked your Macs to do.
- Daily usage counts (transcription minutes, requests, stored messages) to keep the beta affordable.

## For how long

Messages and relays are kept for 30 days, sessions and events for 7 days, the audit log for 90 days. Settings →
Privacy and your data → Delete my data removes everything at once and signs out every device.

## Who can read it

Data is stored in AWS (us-west-2) and encrypted at rest, but not end to end: the operator of the beta can
technically read transcripts. Notification content is end-to-end encrypted. Nothing is sold or shared with
third parties.

## Voice

High-accuracy dictation sends the recording through Axon to OpenAI for transcription. Neither keeps the audio.
On-device dictation never leaves the phone.

## What the app can do

The app can type into, approve, start and stop agents on Macs you pair, with your Mac user's permissions.
Commands are signed on the phone and verified on the Mac.

## Contact

tyr.chen@gmail.com
