###
# Copyright (C) 2014-2016 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: attachments-sortable.directive.coffee
###

AttachmentSortableDirective = ($parse) ->
    link = (scope, el, attrs) ->
        callback = $parse(attrs.tgAttachmentsSortable)

        el.sortable({
            items: "div[tg-bind-scope]"
            handle: "a.settings.icon.icon-drag-v"
            containment: ".attachments"
            dropOnEmpty: true
            helper: 'clone'
            scroll: false
            tolerance: "pointer"
            placeholder: "sortable-placeholder single-attachment"
        })

        el.on "sortstop", (event, ui) ->
            attachment = ui.item.scope().attachment
            newIndex = ui.item.index()

            scope.$apply () ->
                callback(scope, {attachment: attachment, index: newIndex})

        scope.$on "$destroy", -> el.off()

    return {
        link: link
    }

AttachmentSortableDirective.$inject = [
    "$parse"
]

angular.module("taigaComponents").directive("tgAttachmentsSortable", AttachmentSortableDirective)