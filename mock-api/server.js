const express = require('express');
const app = express();
const port = 3000;

app.use(express.json()); // для парсинга JSON

// ЛОГИРОВАНИЕ

app.use((req, res, next) => {
  console.log("----- REQUEST -----");
  console.log("Method:", req.method);
  console.log("URL:", req.originalUrl);
  console.log("Headers:", req.headers);
  console.log("Query:", req.query);
  console.log("Params:", req.params);
  console.log("Body:", req.body);
  console.log("-------------------");
  next();
});

app.use((req, res, next) => {
  const oldJson = res.json;

  res.json = function (data) {
    console.log("----- RESPONSE -----");
    console.log("Status:", res.statusCode);
    console.log("Body:", data);
    console.log("--------------------");
    return oldJson.call(this, data);
  };

  next();
});

// ДАННЫЕ

let vacancies = [
    {
        "id": "54a876a5-2205-48ba-9498-cfecff4baa6e",
        "lookingNumber": 17,
        "title": "UI/UX-дизайнер / Web-дизайнер / Дизайнер интерфейсов",
        "address": {
            "town": "Казань",
            "street": "улица Чистопольская",
            "house": "20/10"
        },
        "company": "Шафигуллин Шакир",
        "isCompanyVerify": true,
        "experience": "from1to3years",
        "publishedDate": "2024-03-06",
        "isFavorite": false,
        "salary": {
            "from": {
                "value": 20000,
                "currency": "rub"
            },
            "to": {
                "value": 50000,
                "currency": "rub"
            }
        },
        "schedules": [
            "shiftSchedule",
            "fullDay"
        ],
        "description": "Мы разрабатываем мобильные приложения, web-приложения и сайты под ключ.\n\nНам в команду нужен UX/UI Designer!",
        "responsibilities": "- Разработка дизайна Web+App (обязательно Figma)\n\n- Работа над созданием и улучшением систем;\n\n- Взаимодействие с командами frontend-разработки и backend-разработки",
        "questions": [
            "workLocation",
            "workSchedule",
            "compensationDetails"
        ],
        "employmentType": "projectWork",
        "businessTrip": "readyRarely"
    },
    {
        "id": "cbf0c984-7c6c-4ada-82da-e29dc698bb50",
        "lookingNumber": 2,
        "title": "UI/UX дизайнер",
        "address": {
            "town": "Минск",
            "street": "улица Бирюзова",
            "house": "4/5"
        },
        "company": "Мобирикс",
        "isCompanyVerify": false,
        "experience": "from1to3years",
        "publishedDate": "2024-02-20",
        "isFavorite": false,
        "salary": null,
        "schedules": [
            "fullDay",
            "fullDay"
        ],
        "appliedNumber": 147,
        "description": "Мы ищем специалиста на позицию UX/UI Designer, который вместе с коллегами будет заниматься проектированием пользовательских интерфейсов внутренних и внешних продуктов компании.",
        "responsibilities": "- проектирование пользовательских сценариев и создание прототипов;\n- разработка интерфейсов для продуктов компании (Web+App);\n- работа над созданием и улучшением Дизайн-системы;\n- взаимодействие с командами frontend-разработки;\n- контроль качества внедрения дизайна;\n- ситуативно: создание презентаций и других материалов на основе фирменного стиля компании",
        "questions": [
            "workLocation",
            "workSchedule",
            "vacancyAvailability",
            "compensationDetails"
        ],
        "employmentType": "full",
        "businessTrip": "ready"
    },
    {
        "id": "75c84407-52e1-4cce-a73a-ff2d3ac031b3",
        "title": "UX/UI Designer",
        "address": {
            "town": "Казань",
            "street": "улица Пушкина",
            "house": "2"
        },
        "company": "Aston",
        "isCompanyVerify": false,
        "experience": "from3to6years",
        "publishedDate": "2024-02-28",
        "isFavorite": true,
        "salary": null,
        "schedules": [
            "fullDay",
            "remote"
        ],
        "appliedNumber": 11,
        "description": "Мы – аутсорсинговая аккредитованная IT-компания Aston, разрабатываем программное обеспечение на заказ и оказываем услуги IT-аутсорсинга предприятиям, организациям и стартапам. Приоритетные направления – финансовые технологии, телеком, ритейл, недвижимость и другие. Среди наших клиентов – компании Тинькофф, Х5 Retail Group, Банки.ру, ВТБ Банк, Альфа Банк, Цифра и другие.\n\nЗаказчик входит в топ-10 российских банков по величине активов, кредитного портфеля, размеру средств, привлеченных от клиентов, и нормативного капитала.\n\nБанк активно развивает онлайн-сервисы и работает по стратегии Mobile first. В компании есть отдельное подразделение, в котором создаются digital-продукты и внедряются цифровые технологии.",
        "responsibilities": "- совместно с Product Owner определять бизнес-метрики, потребности клиентов банка, фиксировать их в формате задач и метрик успешности;\n- изучать лучшие практики и недостатки аналогичных продуктов, проходить путь клиента и формулировать гипотезы решения задач вместе с продуктовой командой;\n- создавать прототипы для проверки гипотез;\n- передавать прототипы на Usability-тесты и контролировать их проведение;\n- улучшать решения по результатам тестов и наблюдений;\n- готовить чистовые макеты на основе компонентов дизайн-системы банка для передачи в разработку;\n- создавать и описывать новые компоненты дизайн-системы по принятым в банке стандартам;\n- отдавать на дизайн-чек макеты и проверять решения других дизайнеров;\n- передавать макеты разработчикам и отвечать на возникающие в процессе разработки вопросы;\n- проводить дизайн-ревью результата разработки и формулировать список замечаний для разработчиков;\n- итеративно совершенствовать дизайн цифрового продукта на основе метрик и отзывов клиентов;\n- участвовать в улучшении процессов центра компетенций продуктового дизайна.",
        "questions": [
            "workLocation",
            "workSchedule",
            "compensationDetails"
        ],
        "employmentType": "partiall",
        "businessTrip": "notReady"
    },
    {
        "id": "16f88865-ae74-4b7c-9d85-b68334bb97db",
        "lookingNumber": 57,
        "title": "Веб-дизайнер",
        "address": {
            "town": "Казань",
            "street": "улица Пушкина",
            "house": "57"
        },
        "company": "Алабуга. Маркетинг и PR",
        "isCompanyVerify": true,
        "experience": "no",
        "publishedDate": "2024-03-02",
        "isFavorite": false,
        "salary": {
            "from": {
                "value": 60000,
                "currency": "rub"
            },
            "to": null
        },
        "schedules": [
            "shiftSchedule",
            "fullDay"
        ],
        "appliedNumber": 7,
        "responsibilities": "- Разработка новых сайтов, приложений, лэндингов;\n- Создание и доработка прототипов готовых к сдаче в верстку;\n- Взаимодействие с подрядчиками по разработке сайтов\n- Доработка существующих сайтов;\n- Проектирование интерфейсов, организация UI/UX-исследований;\n- Взаимодействие с Frontend и Backend разработчиками, техническими специалистами;\n- Работа с дизайн системой, её поддержание.",
        "questions": [
            "workLocation",
            "workSchedule",
            "vacancyAvailability",
            "compensationDetails"
        ],
        "employmentType": "internship",
        "businessTrip": "readyRarely"
    },
    {
        "id": "26f88856-ae74-4b7c-9d85-b68334bb97db",
        "lookingNumber": 29,
        "title": "Ведущий продуктовый дизайнер",
        "address": {
            "town": "Минск",
            "street": "проспект Хасанова",
            "house": "15"
        },
        "company": "ПАО Ростелеком",
        "isCompanyVerify": false,
        "experience": "from3to6years",
        "publishedDate": "2024-02-19",
        "isFavorite": false,
        "salary": null,
        "schedules": [
            "fullDay",
            "remote"
        ],
        "description": "Перед вами не просто вакансия. Перед вами — уникальные возможности, от которых вас отделяет всего один клик.",
        "responsibilities": "— Готовить макеты на основании прототипа и/или описания пользовательских сценариев;\n— Анализировать бизнесовые и пользовательские требования, уточнять постановки от аналитиков и проектировщиков;\n— Создавать графические и стилистические элементы для портала, приложений и промо страниц;\n— Оптимизировать дизайн существующих интерфейсов;\n— Осуществлять авторский контроль над исполнителями;\n— Развивать существующую дизайн-систему и UI-киты;\n— Помогать в подготовке продающих фичи презентаций.",
        "questions": [
            "workLocation",
            "workSchedule",
            "vacancyAvailability",
            "compensationDetails"
        ],
        "employmentType": "voluntteing",
        "businessTrip": "ready"
    },
    {
        "id": "26f88856-ae74-4b7c-9d85-b68334bb99db",
        "lookingNumber": 29,
        "title": "Ведущий продуктовый дизайнер 2",
        "address": {
            "town": "Минск",
            "street": "проспект Хасанова",
            "house": "15"
        },
        "company": "ПАО Ростелеком 2",
        "isCompanyVerify": true,
        "experience": "from3to6years",
        "publishedDate": "2024-02-19",
        "isFavorite": false,
        "salary": null,
        "schedules": [
            "fullDay",
            "remote"
        ],
        "description": "Перед вами не просто вакансия. Перед вами — уникальные возможности, от которых вас отделяет всего один клик.",
        "responsibilities": "— Готовить макеты на основании прототипа и/или описания пользовательских сценариев;\n— Анализировать бизнесовые и пользовательские требования, уточнять постановки от аналитиков и проектировщиков;\n— Создавать графические и стилистические элементы для портала, приложений и промо страниц;\n— Оптимизировать дизайн существующих интерфейсов;\n— Осуществлять авторский контроль над исполнителями;\n— Развивать существующую дизайн-систему и UI-киты;\n— Помогать в подготовке продающих фичи презентаций.",
        "questions": [
            "workLocation",
            "workSchedule",
            "vacancyAvailability",
            "compensationDetails"
        ],
        "employmentType": "partiall",
        "businessTrip": "ready"
    },
    {
        "id": "15f88865-ae74-4b7c-9d81-b78334bb91db",
        "lookingNumber": 1,
        "title": "Product Designer 2",
        "address": {
            "town": "Минск",
            "street": "улица Побратимова",
            "house": "5"
        },
        "company": "TravelLine 2",
        "isCompanyVerify": false,
        "experience": "from3to6years",
        "publishedDate": "2024-02-02",
        "isFavorite": false,
        "salary": null,
        "schedules": [
            "fullDay"
        ],
        "appliedNumber": 1,
        "description": "В TravelLine мы разрабатываем единую функциональную Платформу для автоматизации процессов гостиничного бизнеса. Всё, что связано с онлайн-бронированием и управлением номерным фондом в отелях — это к нам. Ежемесячно через наши системы бронируют более 1,5 миллионов гостей.\n\nМы ищем коллегу в команду продуктовых дизайнеров на В2В продукт.\nСейчас в нашей команде 10 продуктовых дизайнеров, которые занимаются В2В, В2С и В2Е продуктами.\nВ начале пути у тебя будет наставник, который поможет в адаптации к новой команде.",
        "responsibilities": "- Проектировать интерфейс B2B продукта: сопровождать и улучшать текущие решения, поддерживать консистентность\n\n- Понимать потребности и боли пользователей, логику взаимодействия пользователя с продуктом, участвовать в этапе discovery\n\n- Создавать интерактивные прототипы\n\n- Проводить юзабилити-тестирования и ревью реализации решений\n\n- Работать внутри продуктовой команды: коммуницировать с дизайнерами, продакт и проджект менеджерами, аналитиками, разработчиками и тестировщиками.",
        "questions": [
            "workLocation",
            "workSchedule",
            "vacancyAvailability",
            "compensationDetails"
        ],
        "employmentType": "internship",
        "businessTrip": "notReady"
    }
];

// РОУТЫ

app.get("/api/vacancies", (req, res) => {
  const page = parseInt(req.query.page) || 1; // номер страницы
  const limit = 5;

  const startIndex = (page - 1) * limit;
  const endIndex = page * limit;

  const total = vacancies.length;
  const totalPages = Math.ceil(total / limit);

  const items = vacancies.slice(startIndex, endIndex);

  console.log();
  res.json({ items: items, page: page, totalPages: totalPages });
});

// Получить вакансию по id
app.get("/api/vacancies/:id", (req, res) => {
  const vacancy = vacancies.find(v => v.id === req.params.id);
  if (!vacancy) {
    return res.status(404).json({ error: `Vacancy ${req.params.id} not found` });
  }
  res.json(vacancy);
});


// Обновить isFavorite
app.patch("/api/vacancies/:id/favorite", (req, res) => {
  const vacancy = vacancies.find(v => v.id === req.params.id);
  if (!vacancy) {
    return res.status(404).json({ error: `Vacancy ${req.params.id} not found` });
  }

  console.log(vacancy)

  if (typeof req.body.isFavorite !== "boolean") {
    return res.status(400).json({ error: "isFavorite must be boolean" });
  }

  vacancy.isFavorite = req.body.isFavorite;
  res.json(vacancy);
});


// ЗАПУСК СЕРВЕРА

app.listen(port, () => {
  console.log(`Mock API running at http://localhost:${port}`);
});