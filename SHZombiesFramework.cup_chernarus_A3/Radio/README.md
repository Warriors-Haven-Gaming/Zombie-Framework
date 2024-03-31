# Radio

This contains the radio sentences used by the mission. Any audio files here
should include a corresponding entry in [description.ext#CfgRadio]
and [stringtable.xml#CfgRadio].

When submitting new radio clips, it is recommended to apply the following effects
in an audio editor like [Audacity]:

1. Apply a High-Pass Filter at `800Hz` frequency with a rolloff of `36dB`
2. Normalize the audio to `0dB` peak
3. Compress the audio for volume consistency
   (suggested `-24dB` threshold, `2.4:1` ratio)
4. Remove any background noise from the clip

For consistency, no other effects should be applied for simulating radio chatter
as we are in part relying on ARMA's own post-processing to handle this.

Afterwards, trim the start and end of the clip so there is minimal gap between
the start of their first word and the end of their last word (however usually
the last word they speak will need extra time to be fully enunciated).

When exporting, use the Ogg Vorbis format `.ogg` with Mono channel,
the lowest quality of `0`, and a sample rate of `11025Hz`.
The resulting file should be less than 50KB.

[description.ext#CfgRadio]: https://community.bistudio.com/wiki/Description.ext#CfgRadio
[stringtable.xml#CfgRadio]: ../stringtable.xml
[Audacity]: https://www.audacityteam.org/
