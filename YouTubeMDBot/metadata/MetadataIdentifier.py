#                             YouTubeMDBot
#                  Copyright (C) 2019 - Javinator9889
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#      the Free Software Foundation, either version 3 of the License, or
#                   (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#               GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
from io import BytesIO

import acoustid

from .. import AudioUtils


class MetadataIdentifier(object):
    def __init__(self, audio: BytesIO, raw: bytes):
        self.__audio = raw
        self.__audio_info = AudioUtils(audio)

    def _calculate_fingerprint(self) -> bytes:
        return acoustid.fingerprint(self.__audio_info.get_audio_samplerate(),
                                    self.__audio_info.get_audio_channels(),
                                    iter(self.__audio))

    def identify_audio(self) -> list:
        fingerprint = self._calculate_fingerprint()
        return acoustid.lookup(None, fingerprint,
                               self.__audio_info.get_audio_duration())
