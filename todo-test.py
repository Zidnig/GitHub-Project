import unittest
import io
from todo import Task, TaskPool


class TestTaskPool(unittest.TestCase):
    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        self.pool.add_task(Task("New Task"))
        self.assertEqual(len(self.pool.tasks), 1)

    def test_get_open_tasks(self):
        self.pool.populate()
        open_tasks = self.pool.get_open_tasks()
        self.assertEqual(len(open_tasks), 3)
        self.assertTrue(all(t.status == "ToDo" for t in open_tasks))

    def test_get_done_tasks(self):
        self.pool.populate()
        done_tasks = self.pool.get_done_tasks()
        self.assertEqual(len(done_tasks), 3)
        self.assertTrue(all(t.status == "Done" for t in done_tasks))


if __name__ == "__main__":
    suite = unittest.TestLoader().loadTestsFromTestCase(TestTaskPool)
    stream = io.StringIO()
    unittest.TextTestRunner(stream=stream, verbosity=2).run(suite)
    for line in stream.getvalue().splitlines():
        if line.endswith("ok"):
            print(line.split(" (")[0] + " ... ok")
