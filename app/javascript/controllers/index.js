// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import Dialog from '@stimulus-components/dialog'
import Clipboard from '@stimulus-components/clipboard'
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


application.register('dialog', Dialog)
application.register('clipboard', Clipboard)
